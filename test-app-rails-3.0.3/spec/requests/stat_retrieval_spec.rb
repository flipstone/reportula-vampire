require 'spec_helper'

describe "stats retrieval" do
  describe "GET auto model count" do
    it "responds with success" do
      get "/reportula-vampire/stats/foos/count"
      response.should be_success
    end

    it "responds with 0 when there are no models" do
      get "/reportula-vampire/stats/foos/count"
      ActiveSupport::JSON.decode(response.body)["value"].should == 0
    end

    it "counts foo models" do
      3.times { Foo.create! }
      get "/reportula-vampire/stats/foos/count"
      ActiveSupport::JSON.decode(response.body)["value"].should == 3
    end

    it "counts bar models" do
      2.times { Bar.create! }
      get "/reportula-vampire/stats/bars/count"
      ActiveSupport::JSON.decode(response.body)["value"].should == 2
    end

    it "sets the content type" do
      get "/reportula-vampire/stats/foos/count"
      response["Content-Type"].should == "application/json"
    end

    it "returns 404 for non-existent model" do
      get "/reportula-vampire/stats/bargles/count"
      response.should be_not_found
    end

    it "returns 404 for unrecognized reportula-vampire route" do
      get "/reportula-vampire/slurplepurple"
      response.should be_not_found
    end

    it "delegates to app for non reportual-vampire route" do
      get "/echo", t: "Chortle"
      response.should be_success
      response.body.should == "Chortle"
    end

    it "sets unit" do
      get "/reportula-vampire/stats/foos/count"
      ActiveSupport::JSON.decode(response.body)["unit"].should == "Foo"
    end

    it "sets measure" do
      get "/reportula-vampire/stats/foos/count"
      ActiveSupport::JSON.decode(response.body)["measure"].should == "Foo Count"
    end
  end

  describe "GET stats index" do
    it "responds with success" do
      get "/reportula-vampire/stats"
      response.should be_success
    end

    it "lists all auto-model count urls" do
      get "/reportula-vampire/stats"
      locations = ActiveSupport::JSON.decode(response.body)["stat_locations"]
      locations.should have(2).entries
      locations.should include("/reportula-vampire/stats/foos/count")
      locations.should include("/reportula-vampire/stats/bars/count")
    end

    it "sets Content-Type" do
      get "/reportula-vampire/stats"
      response["Content-Type"].should == "application/json"
    end
  end
end
