module Api
  class ApiController < ApplicationController
    skip_before_action :verify_authenticity_token
    respond_to :json

    def initialize
      @messages = []
      @errors = []
      @status = I18n.t('api.status.default')
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

    def error!(err, status = I18n.t('api.status.error'))
      return unless err
      @errors.push(err)
      @status = status
    end

    def data_set!(key, value, status = I18n.t('api.status.success'))
      return unless key
      @data = {} unless @data
      @data[key] = value
      @status = status
    end

    def options_set!(key, value)
      return unless key
      @render_options[key] = value
    end

    def render_j(&block)
      options_set! :json, _json
      render @render_options, @extra_options, &block
    end

    def not_authorized_nil_user!
      not_authorized!
    end

    def not_authorized!
      error! I18n.t('authorization.not_authorized')
      options_set! :status, :unauthorized
      render_j
    end

  end
end
