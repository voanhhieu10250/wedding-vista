class Vendors::BaseController < ApplicationController
  layout "vendor"
  before_action :authenticate_vendor!
end
