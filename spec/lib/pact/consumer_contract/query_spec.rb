require 'pact/consumer_contract/query'

module Pact
  describe Query do
    describe ".parse_string" do
      subject { Query.parse_string(query_string) }

      describe "with a non nested query string" do
        let(:query_string) { "foo=bar1" }

        it "returns a map of string to array" do
          expect(subject).to eq "foo" => ["bar1"]
        end
      end

      describe "with a non nested query string with multiple params with the same name" do
        let(:query_string) { "foo=bar1&foo=bar2" }

        it "returns a map of string to array" do
          expect(subject).to eq "foo" => ["bar1", "bar2"]
        end
      end

      describe "with a rails style nested query" do
        let(:query_string) { "foo=bar1&foo=bar2&baz[]=thing1&baz[]=thing2" }

        it "returns a nested map" do
          expect(subject).to eq "foo" => "bar2", "baz" => ["thing1", "thing2"]
        end
      end
    end
  end
end
