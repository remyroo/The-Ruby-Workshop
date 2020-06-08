# frozen_string_literal: true

module ApplicationDebugger
  def debug(args)
    puts "Application debug start: #{args.inspect}"
    result = super # calls the debug method defined above it in the heirarchy
    puts "Application debug finished: #{result}"
  end
end
class Application
  prepend ApplicationDebugger

  def debug(_args)
    { result: 'ok' }
  end
end

Application.ancestors # [ApplicationDebugger, Application, Object, Kernel, BasicObject]
DBugger = Application.new
DBugger.debug('NotePad')
