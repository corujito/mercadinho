class ReportsController < ApplicationController
  before_action :authenticate_user!
  authorize_resource :class => false

  def sales
    @orders = []
    if !params[:start_date].blank? and !params[:end_date].blank?
      @start_date = Time.zone.parse(params[:start_date]).beginning_of_day
      @end_date = Time.zone.parse(params[:end_date]).end_of_day
    end
  end

  def general
    @purchases = []
    @orders = []
    @payments = []
    @products = []
    if !params[:start_date].blank? and !params[:end_date].blank?
      @start_date = Time.zone.parse(params[:start_date]).beginning_of_day
      @end_date = Time.zone.parse(params[:end_date]).end_of_day
      @purchases = Purchase.where(:created_at => @start_date..@end_date)
      @orders = Order.where(:created_at => @start_date..@end_date)
      @payments = Payment.where(:created_at => @start_date..@end_date)
      @custom_input_negative = CustomInput.where(:created_at => @start_date..@end_date, input_type: CustomInput.input_types[:despesa])
      @custom_input_positive = CustomInput.where(:created_at => @start_date..@end_date, input_type: CustomInput.input_types[:ganho])
      @products = Product.all
    end
  end
end
