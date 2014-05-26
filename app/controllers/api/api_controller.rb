module Api
  class ApiController < ApplicationController
    skip_before_action :verify_authenticity_token
    respond_to :json

    def initialize
      @messages = []
      @errors = []
      @status = 'default'
      @render_options = {}
      @render_extra_options = {}
    end

    def _json
      {
        status: @status,
        data: @data,
        messages: @messages,
        errors: @errors
      }
    end

    def error!(err, status = 'error')
      if err
        @errors.push(err)
        @status = status
      end
    end

    def data_set!(key, value, status = 'success')
      if key
        @data = {} unless @data
        @data[key] = value
        @status = status
      end
    end

    def options_set!(key, value)
      if key
        @render_options[key] = value
      end
    end

    def render_j(&block)
      options_set! :json, _json
      render @render_options, @extra_options, &block
    end

    def not_authorized_nil_user
      error! 'not authorized'
      options_set! :status, :unauthorized
      render_j
    end

  end
end
