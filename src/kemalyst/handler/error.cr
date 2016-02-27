class Kemalyst::Exceptions::RouteNotFound < Exception 
end

module Kemalyst::Handler
  class Error < Base

    def call(context)
      begin
        call_next(context)
      rescue ex : Kemalyst::Exceptions::RouteNotFound
        context.response.status_code = 404
        context.response.content_type = "text/plain"
        context.response.print(ex.message)
      rescue ex : Exception
        context.response.status_code = 500
        context.response.content_type = "text/plain"
        context.response.print("ERROR: ")
        ex.inspect_with_backtrace(context.response)
      end
    end

  end
end
