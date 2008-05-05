require 'choice'

Choice.options do
  header 'Run waves in console mode.'
  header ''
  option :mode do
    short '-c'
    long '--config=CONFIG'
    desc 'Configuration to use.'
    desc 'Defaults to development.'
    cast Symbol
  end
  separator ''
end

console = Waves::Console.load( Choice.choices )
Object.send(:define_method, :waves) { console }
Object.instance_eval do
  include Waves::Verify::Helpers::Reques
end
require 'irb'
require 'irb/completion'
ARGV.clear
IRB.star
