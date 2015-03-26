class TestReportsController < ApplicationController
  protect_from_forgery with: :null_session

  def create
    test_report = TestReport.create!(json: request.body.read)
    render json: Response.new(test_report.build)
  end

  Response = Struct.new(:build) do
    def as_json(*)
      {
        current: build,
           base: build.base_build
      }
    end
  end
end
