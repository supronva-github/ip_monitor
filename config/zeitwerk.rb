# frozen_string_literal: true

loader = Zeitwerk::Loader.new
loader.push_dir(File.expand_path('../lib', __dir__))
loader.collapse([
                  File.expand_path('../lib/model', __dir__),
                  File.expand_path('../lib/services', __dir__),
                  File.expand_path('../lib/blueprints', __dir__),
                  File.expand_path('../lib/contracts', __dir__),
                  File.expand_path('../lib/workers', __dir__)
                ])
loader.setup
