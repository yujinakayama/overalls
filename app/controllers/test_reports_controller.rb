class TestReportsController < ApplicationController
  protect_from_forgery with: :null_session

  def create
    TestReport.create!(json: request.body.read)
    head 200
  end
end
