require_relative 'file_reader/handler'

module CSstats
  module Parser
    class FileReader
      attr_reader :file_path, :limit

      def initialize(file_path, options = {})
        @file_path = file_path
        @limit = options[:limit] || 0

        raise CSstats::FileNotExist unless File.exist?(file_path.to_s)
      end

      def read(&block)
        return unless block_given?

        file = File.new(file_path, 'r')

        # Need to read first data, which means file version.
        _file_version = Handler.new(file).read_short_data

        read_data(file, &block)

        file.close
      end

      private

      def read_data(file, &_block)
        index = 0
        while !file.eof? && (limit.zero? || index < limit)
          yield(Handler.new(file), index)
          index += 1
        end
      end
    end
  end
end
