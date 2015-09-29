class ReportsController < ApplicationController
  before_action :authenticate_user!

  def sales
    @orders = []
    if !params[:start_date].blank? and !params[:end_date].blank?
      @start_date = Time.zone.parse(params[:start_date]).beginning_of_day
      @end_date = Time.zone.parse(params[:end_date]).end_of_day

      @orders = Order.get_orders(@start_date, @end_date).includes(:client)
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
      @products = Product.all
    end
  end
end
