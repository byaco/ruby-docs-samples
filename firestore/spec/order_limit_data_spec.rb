require_relative "../get_data.rb"
require_relative "../order_limit_data.rb"
require_relative "helpers.rb"
require "rspec"

describe "Google Cloud Firestore API samples - Order Limit Data" do

  before do
    @firestore_project = ENV["FIRESTORE_PROJECT_ID"]
  end

  after do
    delete_collection_test collection_name: "cities", project_id: ENV["FIRESTORE_PROJECT_ID"]
  end

  # Capture and return STDOUT output by block
  def capture &block
    real_stdout = $stdout
    $stdout = StringIO.new
    block.call
    $stdout.string
  ensure
    $stdout = real_stdout
  end

  example "order_by_name_limit_query" do
    retrieve_create_examples project_id: @firestore_project
    output = capture {
      order_by_name_limit_query project_id: @firestore_project
    }
    expect(output).to include "Document BJ returned by order by name with limit query."
    expect(output).to include "Document LA returned by order by name with limit query."
    expect(output).to include "Document SF returned by order by name with limit query."
    expect(output).not_to include "Document TOK returned by order by name with limit query."
    expect(output).not_to include "Document DC returned by order by name with limit query."
  end

  example "order_by_name_desc_limit_query" do
    retrieve_create_examples project_id: @firestore_project
    output = capture {
      order_by_name_desc_limit_query project_id: @firestore_project
    }
    expect(output).to include "Document DC returned by order by name descending with limit query."
    expect(output).to include "Document TOK returned by order by name descending with limit query."
    expect(output).to include "Document SF returned by order by name descending with limit query."
    expect(output).not_to include "Document LA returned by order by name descending with limit query."
    expect(output).not_to include "Document BJ returned by order by name descending with limit query."
  end

  example "order_by_state_and_population_query" do
    retrieve_create_examples project_id: @firestore_project
    output = capture {
      order_by_state_and_population_query project_id: @firestore_project
    }
    expect(output).to include "Document LA returned by order by state and descending population query."
    expect(output).to include "Document SF returned by order by state and descending population query."
    expect(output).to include "Document BJ returned by order by state and descending population query."
    expect(output).to include "Document TOK returned by order by state and descending population query."
    expect(output).to include "Document DC returned by order by state and descending population query."
  end

  example "where_order_by_limit_query" do
    retrieve_create_examples project_id: @firestore_project
    output = capture {
      where_order_by_limit_query project_id: @firestore_project
    }
    expect(output).to include "Document LA returned by where order by limit query."
    expect(output).to include "Document TOK returned by where order by limit query."
    expect(output).not_to include "Document BJ returned by where order by limit query."
    expect(output).not_to include "Document SF returned by where order by limit query."
    expect(output).not_to include "Document DC returned by where order by limit query."
  end

  example "range_order_by_query" do
    retrieve_create_examples project_id: @firestore_project
    output = capture {
      range_order_by_query project_id: @firestore_project
    }
    expect(output).to include "Document LA returned by range with order by query."
    expect(output).to include "Document TOK returned by range with order by query."
    expect(output).to include "Document BJ returned by range with order by query."
    expect(output).not_to include "Document SF returned by range with order by query."
    expect(output).not_to include "Document DC returned by range with order by query."
  end

  example "invalid_range_order_by_query" do
    retrieve_create_examples project_id: @firestore_project
    invalid_range_order_by_query project_id: @firestore_project
  end
end
