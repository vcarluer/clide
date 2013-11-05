// ---------------------------------------------------------------------
// <copyright file="CSContinuousBuild.cs" company="GamersAssociate">
// 	Copyright (c) GamersAssociate. All Rights Reserved
// </copyright>
// <author>Vincent Carluer</author>
// ---------------------------------------------------------------------

using System.Security.Permissions;

namespace CSContinuousBuild
{
	using System;
	using System.Diagnostics;
	using System.IO;
	using System.Timers;

	/// <summary>
	/// Main program
	/// </summary>
	class Program
	{
		private static volatile bool isCompiling = false;

		private static string toBuild;

		private static Process process;

		private static bool endBuildOutputPassed;

		private static string path;

		private static long MinimalWait = 30;

		private static DateTime LastBuild;

		private static bool waitWarningDone;

		private static Timer buildTimer;

		private static bool buildPending;

		/// <summary>
		/// Mains the specified args.
		/// </summary>
		/// <param name="args">The args.</param>
		static void Main(string[] args)
		{
			Run();
		}

		/// <summary>
		/// Runs this instance.
		/// </summary>
		[PermissionSet(SecurityAction.Demand, Name = "FullTrust")]
		private static void Run()
		{
			string[] args = System.Environment.GetCommandLineArgs();
			path = Directory.GetCurrentDirectory();
			if (args.Length > 3)
			{
				Console.WriteLine("Usage: CSCB.exe (directory) (fileToBuild)");
				return;
			}
			else
			{
				if (args.Length >= 2)
				{
					if (Path.IsPathRooted(args[1]))
					{
						path = args[1];
					}
					else
					{
						path = Path.Combine(path, args[1]);
					}
				}

				if (args.Length == 3)
				{
					toBuild = Path.Combine(path, args[2]);
				}
			}

			Environment.CurrentDirectory = path;
			FileSystemWatcher fsw = new FileSystemWatcher(path, "*.cs*");
			fsw.IncludeSubdirectories = true;

			fsw.NotifyFilter =
				NotifyFilters.LastWrite |
				NotifyFilters.FileName |
				NotifyFilters.DirectoryName;

			fsw.Changed += fsw_Changed;
			fsw.Deleted += fsw_Changed;
			fsw.Created += fsw_Changed;
			fsw.Renamed += fsw_Renamed;

			fsw.EnableRaisingEvents = true;

			ShowInfo();
			Compile();
			var c = Console.Read();
			while (c != 'q')
			{
				if (c == 'b')
				{
					Compile(true);
				}

				c = Console.Read();
			}
		}

		static void fsw_Renamed(object sender, RenamedEventArgs e)
		{
			// Console.WriteLine("Renamed to: " + e.FullPath);
			Compile();
		}

		static void fsw_Changed(object sender, FileSystemEventArgs e)
		{
			// Console.WriteLine(e.ChangeType + ": " + e.FullPath);
			Compile();
		}

		static void Compile()
		{
			Compile(false);
		}

		/// <summary>
		/// Main compile method
		/// </summary>
		/// <param name="force">Force the compilation</param>
		static void Compile(bool force)
		{
			if (buildTimer != null)
			{
				buildTimer.Enabled = false;
				buildTimer.Dispose();
				buildTimer = null;
			}

			if (isCompiling)
			{
				// Disabled for now: Build modify files => infinite loop
				// Modification during loop will not trigger a build
				// buildPending = true;
				return;
			}
			else
			{
				if (TriggerBuild(force)) return;

				waitWarningDone = false;
				isCompiling = true;
			}

			string msb = @"C:\Windows\Microsoft.NET\Framework64\v4.0.30319\MsBuild.exe";
			string param = "/tv:4.0 /m";
			if (!String.IsNullOrEmpty(toBuild))
			{
				param += " " + toBuild;
			}

			process = new Process();
			ProcessStartInfo start = new ProcessStartInfo(msb, param);
			start.UseShellExecute = false;
			start.RedirectStandardOutput = true;

			process.StartInfo = start;
			process.OutputDataReceived += process_OutputDataReceived;

			Console.WriteLine("CSCB - Building...");
			process.Exited += process_Exited;
			process.EnableRaisingEvents = true;

			endBuildOutputPassed = false;
			process.Start();
			process.BeginOutputReadLine();
		}

		static void process_OutputDataReceived(object sender, DataReceivedEventArgs e)
		{
			if (!String.IsNullOrEmpty(e.Data))
			{
				string[] lines = e.Data.Split(new string[] { Environment.NewLine }, StringSplitOptions.None);
				foreach (var line in lines)
				{
					if (!endBuildOutputPassed &&
						(line.Equals("Build FAILED.", StringComparison.InvariantCultureIgnoreCase) ||
						line.Equals("Build succeeded.")))
					{
						endBuildOutputPassed = true;
					}

					if (endBuildOutputPassed)
					{
						if (line.Contains("error") || line.Contains("FAILED"))
						{
							Console.BackgroundColor = ConsoleColor.DarkRed;
							Console.ForegroundColor = ConsoleColor.Black;
						}

						if (line.Contains("warning"))
						{	
							Console.BackgroundColor = ConsoleColor.Black;
							Console.ForegroundColor = ConsoleColor.DarkYellow;
						}

						if (line.Contains("succeeded"))
						{
							Console.BackgroundColor = ConsoleColor.Green;
							Console.ForegroundColor = ConsoleColor.Black;
						}

						Console.WriteLine(line);
						Console.ResetColor();
					}
				}
			}
		}

		/// <summary>
		/// Handles the Exited event of the process control.
		/// </summary>
		/// <param name="sender">The source of the event.</param>
		/// <param name="e">The <see cref="EventArgs"/> instance containing the event data.</param>
		static void process_Exited(object sender, EventArgs e)
		{
			processEnd();
		}

		/// <summary>
		/// Processes the end.
		/// </summary>
		static void processEnd()
		{
			isCompiling = false;
			LastBuild = DateTime.UtcNow;
			Console.WriteLine("CSCB - Build done - " + LastBuild.ToLocalTime().ToString());
			ShowInfo();
			if (buildPending)
			{
				buildPending = false;
				Compile();
			}
		}

		static void ShowInfo()
		{
			Console.WriteLine("CSCB - Watching " + path);
			string buildInfo = toBuild;
			if (String.IsNullOrEmpty(buildInfo))
			{
				buildInfo = "Default solution or project in watched directory";
			}

			Console.WriteLine("CSCB - Building: " + buildInfo);
			Console.WriteLine("CSCB - Press \'q\' to quit CSContinuousBuild");
			Console.WriteLine("CSCB - Press \'b\' to force a new build");
		}

		static void OnTimedEvent(object source, ElapsedEventArgs e)
		{
			Compile();
		}

		static bool TriggerBuild(bool force)
		{
			double elapsed = DateTime.UtcNow.Subtract(LastBuild).TotalSeconds;
			double remaining = MinimalWait - elapsed;
			return TriggerBuild(force, remaining);	
		}

		static bool TriggerBuild(bool force, double remaining)
		{
			bool buildTriggered = false;
			if (!force && remaining > 0)
			{
				if (!waitWarningDone)
				{
					Console.WriteLine("CSCB - Build will be triggered in " + remaining.ToString() + " second(s). Event(s) occured in code but no build were performed for now because it's too close from last build.");
					waitWarningDone = true;
				}

				if (buildTimer == null)
				{
					buildTimer = new Timer(remaining);
					buildTimer.Elapsed += OnTimedEvent;
					buildTimer.Enabled = true;
				}

				buildTriggered = true;
			}

			return buildTriggered;
		}
	}
}
