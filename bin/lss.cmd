ls %1 -la -F | grep "^d" && ls %1 -la -F | grep "^-" && ls %1 -al -F | grep -v "^[d|-]"

