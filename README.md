# How to Use RspecManualOrder

- use `--format documentation` in your `.rspec` file
- copy the output of `rake spec` into a file
- add `RspecManualOrder.new("documentation_output.txt").order(config)` to your spec_helper file
- rerun `rake spec` and verify you still see the failure
