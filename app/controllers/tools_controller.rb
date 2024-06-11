class ToolsController < ApplicationController
  def index
    @services = Service.search("").limit(5)
  end

  def checklist
  end

  def budget
  end

  def vendors
  end
end
