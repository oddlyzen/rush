class Rush::Box
	attr_reader :host

	def initialize(host='localhost')
		@host = host
	end

	def to_s
		host
	end

	def inspect
		host
	end

	def filesystem
		Rush::Entry.factory('/', self)
	end

	def [](key)
		filesystem[key]
	end

	def processes
		connection.processes.map do |ps|
			Rush::Process.new(ps, self)
		end
	end

	def connection
		@connection ||= make_connection
	end

	def make_connection
		host == 'localhost' ? Rush::Connection::Local.new : Rush::Connection::Remote.new(host)
	end

	def ==(other)
		host == other.host
	end
end
