require "spec_helper"

describe Mascot::ResourcesPipeline do
  let(:site) { Mascot::Site.new(root: "spec/pages") }
  subject{ site.resources_pipeline }

  describe "#process" do
    it "calls #process on processor" do
      processor = double("Object", process_resources: [])
      expect(processor).to receive(:process_resources)
      subject << processor
      site.resources
    end
  end
end
