class SmartAnswerTestHelper
  def self.data_path
    Rails.root.join('test', 'data')
  end

  def initialize(flow_name)
    @flow_name = flow_name
  end

  def question_and_responses_path
    data_path.join(question_and_responses_filename)
  end

  def write_questions_and_responses(questions_and_responses)
    FileUtils.mkdir_p(data_path)
    File.open(question_and_responses_path, 'w') do |file|
      file.puts(questions_and_responses.to_yaml)
    end
  end

  def responses_and_expected_results_path
    data_path.join(responses_and_expected_results_filename)
  end

  def write_responses_and_expected_results(data)
    File.open(responses_and_expected_results_path, 'w') do |file|
      file.puts(data.to_yaml)
    end
  end

  private

  def question_and_responses_filename
    "#{@flow_name}-questions-and-responses.yml"
  end

  def responses_and_expected_results_filename
    "#{@flow_name}-responses-and-expected-results.yml"
  end

  def data_path
    self.class.data_path
  end
end
