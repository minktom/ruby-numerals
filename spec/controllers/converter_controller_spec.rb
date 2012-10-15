require 'spec_helper'

describe ConverterController do
  integrate_views

  it "should render index page" do
    get :index
    response.should render_template(:partial => 'converter/_form')
  end

  it "should render phrase text" do
    post 'phrase', :number => 42
    response.body.should match(/forty-two/)
  end

end
