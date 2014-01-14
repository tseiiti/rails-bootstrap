class ApplicationController < ActionController::Base
	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :exception
	before_filter :configure_permitted_parameters, if: :devise_controller?

	SimpleForm.setup do |config|
		config.wrappers :bootstrap, tag: 'div', class: 'form-group', error_class: 'error' do |b|
			b.use :html5
			b.use :placeholder
			b.use :label
			b.wrapper :controls, tag: 'div', class: 'col-lg-6' do |ba|
				ba.use :input
				ba.use :error, wrap_with: { tag: 'span', class: 'help-inline' }
				ba.use :hint,  wrap_with: { tag: 'p', class: 'help-block' }
			end
		end

		config.wrappers :inline_checkbox, tag: 'div', class: 'form-group', error_class: 'error' do |b|
		  b.use :html5
		  b.use :placeholder
		  b.wrapper tag: 'div', class: 'col-lg-offset-2 col-lg-6' do |ba|
		    ba.use :label_input, class: 'checkbox inline'
				ba.use :error, wrap_with: { tag: 'span', class: 'help-inline' }
				ba.use :hint,  wrap_with: { tag: 'p', class: 'help-block' }
		  end
		end

		config.default_wrapper 					= :bootstrap
		config.error_notification_class = 'alert alert-danger'
		config.label_class							= 'col-lg-2 control-label'
		config.form_class								= 'form-horizontal'
		config.input_class 							= 'form-control'
	end

protected

	def configure_permitted_parameters
		devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :email, :password, :password_confirmation, :remember_me) }
		devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :username, :email, :password, :remember_me) }
		devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:username, :email, :password, :password_confirmation, :current_password) }
	end
end