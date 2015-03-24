# encoding: utf-8
require 'test_helper'
require 'smartdown_plugins/pay-leave-for-parents/render_time'

module SmartdownPlugins

  class PayLeaveForParentsAdoptersTest < ActiveSupport::TestCase

    due_date = Smartdown::Model::Answer::Date.new("2015-1-1")

    test "continuity_start_date" do
      expected = Smartdown::Model::Answer::Date.new("2014-3-29")
      assert_equal expected, SmartdownPlugins::PayLeaveForParents.continuity_start_date(due_date)
    end

    test "continuity_end_date" do
      expected = Smartdown::Model::Answer::Date.new("2014-9-14")
      assert_equal expected, SmartdownPlugins::PayLeaveForParents.continuity_end_date(due_date)
    end

    test "earnings_employment_start_date" do
      expected = Smartdown::Model::Answer::Date.new("2013-9-22")
      assert_equal expected, SmartdownPlugins::PayLeaveForParents.earnings_employment_start_date(due_date)
    end

    test "earnings_employment_end_date" do
      expected = Smartdown::Model::Answer::Date.new("2014-12-27")
      assert_equal expected, SmartdownPlugins::PayLeaveForParents.earnings_employment_end_date(due_date)
    end

    test "lower_earnings_start_date" do
      expected = Smartdown::Model::Answer::Date.new("2014-7-26")
      assert_equal expected, SmartdownPlugins::PayLeaveForParents.lower_earnings_start_date(due_date)
    end

    test "lower_earnings_end_date" do
      expected = Smartdown::Model::Answer::Date.new("2014-9-20")
      assert_equal expected, SmartdownPlugins::PayLeaveForParents.lower_earnings_end_date(due_date)
    end

    test "earliest_start_mat_leave" do
      expected = Smartdown::Model::Answer::Date.new("2014-10-12")
      assert_equal expected, SmartdownPlugins::PayLeaveForParents.earliest_start_mat_leave(due_date)
    end

    test "end_of_additional_paternity_leave" do
      expected = Smartdown::Model::Answer::Date.new("2016-1-1")
      assert_equal expected, SmartdownPlugins::PayLeaveForParents.end_of_additional_paternity_leave(due_date)
    end

    test "end_of_shared_parental_leave" do
      expected = Smartdown::Model::Answer::Date.new("2016-1-1")
      assert_equal expected, SmartdownPlugins::PayLeaveForParents.end_of_shared_parental_leave(due_date)
    end

    test "latest_pat_leave" do
      expected = Smartdown::Model::Answer::Date.new("2015-2-26")
      assert_equal expected, SmartdownPlugins::PayLeaveForParents.latest_pat_leave(due_date)
    end

    test "maternity_leave_notice_date" do
      expected = Smartdown::Model::Answer::Date.new("2014-9-20")
      assert_equal expected, SmartdownPlugins::PayLeaveForParents.maternity_leave_notice_date(due_date)
    end

    test "paternity_leave_notice_date" do
      expected = Smartdown::Model::Answer::Date.new("2014-9-20")
      assert_equal expected, SmartdownPlugins::PayLeaveForParents.paternity_leave_notice_date(due_date)
    end

    test "start_of_additional_paternity_leave" do
      expected = Smartdown::Model::Answer::Date.new("2015-5-21")
      assert_equal expected, SmartdownPlugins::PayLeaveForParents.start_of_additional_paternity_leave(due_date)
    end

    test "start_of_maternity_allowance" do
      expected = Smartdown::Model::Answer::Date.new("2014-10-12")
      assert_equal expected, SmartdownPlugins::PayLeaveForParents.start_of_maternity_allowance(due_date)
    end


    test "rate_of_maternity_allowance returns 138.18 when 90% of the given weekly salary is higher than £138.18" do
      salary_1 = Smartdown::Model::Answer::Salary.new("200-week")
      assert_equal 138.18, SmartdownPlugins::PayLeaveForParents.rate_of_maternity_allowance(salary_1)
    end

    test "rate_of_maternity_allowance returns 90% of the given weekly salary when it is less than £138.18" do
      salary_1 = Smartdown::Model::Answer::Salary.new("150-week")
      assert_equal 135.0, SmartdownPlugins::PayLeaveForParents.rate_of_maternity_allowance(salary_1)
    end

    test "rate_of_paternity_pay returns 138.18 when 90% of the given weekly salary is higher than £138.18" do
      salary_2 = Smartdown::Model::Answer::Salary.new("200-week")
      assert_equal 138.18, SmartdownPlugins::PayLeaveForParents.rate_of_paternity_pay(salary_2)
    end

    test "rate_of_paternity_pay returns 90% of the given weekly salary when it is less than £138.18" do
      salary_2 = Smartdown::Model::Answer::Salary.new("150-week")
      assert_equal 135.0, SmartdownPlugins::PayLeaveForParents.rate_of_paternity_pay(salary_2)
    end

    test "rate_of_shpp returns 138.18 when 90% of the given weekly salary is higher than £138.18" do
      salary_1 = Smartdown::Model::Answer::Salary.new("200-week")
      assert_equal 138.18, SmartdownPlugins::PayLeaveForParents.rate_of_shpp(salary_1)
    end

    test "rate_of_shpp returns 90% of the given weekly salary when it is less than £138.18" do
      salary_1 = Smartdown::Model::Answer::Salary.new("150-week")
      assert_equal 135.0, SmartdownPlugins::PayLeaveForParents.rate_of_shpp(salary_1)
    end

    test "rate_of_smp_6_weeks returns 90% of the given weekly salary" do
      salary_1 = Smartdown::Model::Answer::Salary.new("150-week")
      assert_equal 135.0, SmartdownPlugins::PayLeaveForParents.rate_of_smp_6_weeks(salary_1)
    end

    test "rate_of_smp_33_weeks returns 90% of the given weekly salary when it is less than £138.18" do
      salary_1 = Smartdown::Model::Answer::Salary.new("150-week")
      assert_equal 135.0, SmartdownPlugins::PayLeaveForParents.rate_of_smp_33_weeks(salary_1)
    end

    test "rate_of_smp_33_weeks returns 138.18 when 90% of the given weekly salary is higher than £138.18" do
      salary_1 = Smartdown::Model::Answer::Salary.new("200-week")
      assert_equal 138.18, SmartdownPlugins::PayLeaveForParents.rate_of_smp_33_weeks(salary_1)
    end

    test "total_aspp returns the rate_of_paternity_pay * 26" do
      salary = Smartdown::Model::Answer::Salary.new("200-week")
      SmartdownPlugins::PayLeaveForParents.stubs(:rate_of_paternity_pay).with(salary).returns(138.18)
      assert_equal 138.18 * 26, SmartdownPlugins::PayLeaveForParents.total_aspp(salary)
    end

    test "total_maternity_allowance returns the rate_of_maternity_allowance * 39" do
      salary_1 = Smartdown::Model::Answer::Salary.new("200-week")
      SmartdownPlugins::PayLeaveForParents.stubs(:rate_of_maternity_allowance).with(salary_1).returns(138.18)
      assert_equal 138.18 * 39, SmartdownPlugins::PayLeaveForParents.total_maternity_allowance(salary_1)
    end

    test "total_smp returns the rate_of_smp_6_weeks * 6 + rate_of_smp_33_weeks * 33 (totaling 39 weeks)" do
      salary_1 = Smartdown::Model::Answer::Salary.new("200-week")
      SmartdownPlugins::PayLeaveForParents.stubs(:rate_of_smp_6_weeks).with(salary_1).returns(1.0)
      SmartdownPlugins::PayLeaveForParents.stubs(:rate_of_smp_33_weeks).with(salary_1).returns(100.0)
      assert_equal 3306.0, SmartdownPlugins::PayLeaveForParents.total_smp(salary_1)
    end
  end
end
