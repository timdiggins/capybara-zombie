require "childprocess"

module Capybara
  module Zombie
    class Executer
      
      def animate!
        unless self.process
          # puts "starting zombie..."
          self.process = ChildProcess.new("env node #{executer_path}")
          self.process.start
          sleep 0.5
          raise("Zombie is not running") unless self.process.alive?
        end
      end
      
      def kill
        if self.process
          # puts "killing zombie..."
          self.process.stop if self.process.alive?
          self.process = nil
          sleep 0.5
        end
      end
      
    protected
      
      attr_accessor :process
      
      def executer_path
        @executer_path ||= File.join(File.expand_path(File.dirname(__FILE__)), "executer.js")
      end
      
    end
  end
end