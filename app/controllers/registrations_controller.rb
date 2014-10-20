class RegistrationsController < Devise::RegistrationsController
   before_filter :configure_permitted_parameters, if: :devise_controller?

  def new
    super
  end

  def create
    build_resource(sign_up_params)

    resource_saved = resource.save

    # Custom code: Save their preferences
    resource.cuisines << Cuisine.find_by(name: params[:cuisine_1]) if params[:cuisine_1]
    resource.cuisines << Cuisine.find_by(name: params[:cuisine_2]) if params[:cuisine_2]
    resource.cuisines << Cuisine.find_by(name: params[:cuisine_3]) if params[:cuisine_3]

    resource.budget = params[:user][:budget]

    resource.save
    
    yield resource if block_given?
    if resource_saved
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_flashing_format?
        sign_up(resource_name, resource)
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      @validatable = devise_mapping.validatable?
      if @validatable
        @minimum_password_length = resource_class.password_length.min
      end
      respond_with resource
    end
  end

  def update
    super
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:user) { |u| u.permit(:budget) }
  end

end
