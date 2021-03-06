require 'spec_helper'

describe 'ClassGroup Courses' do

  stub_authorization!

  let(:class_group) { create(:class_group, :grade => '1', :name => "Not so awesome class group", :homeroom => 'A1') }
  let(:course) { create(:course, :code => 'Math2012') }

  before :all do
    set_resource "class-group-course"
  end

  context 'new', :js => true do
    before do
      course
      visit gaku.class_group_path(class_group)
      click tab_link
      click new_link
      wait_until_visible submit
    end

    it 'creates and shows' do
      expect do
        select "#{course.code}", :from => 'class_group_course_enrollment_course_id'
        click submit
        wait_until_invisible form
      end.to change(Gaku::ClassGroupCourseEnrollment, :count).by 1

      within(table) { page.should have_content "#{course.code}" }
      within(count_div) { page.should have_content "Courses list(1)" }
      within(tab_link) { page.should have_content "Courses(1)" }
      flash_created?
    end

    it { has_validations? }

    it 'cancels creating', :cancel => true do
      ensure_cancel_creating_is_working
    end
  end

  context 'existing', :js => true do
    before do
      class_group.courses << course
      visit gaku.class_group_path(class_group)
      click tab_link

      within(count_div) { page.should have_content "1" }
      within(tab_link) { page.should have_content "1" }
    end

    it "doesn't add a course 2 times" do
      click new_link
      wait_until_visible form
      select "#{course.code}", :from => 'class_group_course_enrollment_course_id'
      click submit
      wait_until { page.should have_content "Already enrolled to the class group!" }
    end

    it 'deletes' do
      within(table) { page.should have_content "#{course.code}" }
      within(count_div) { page.should have_content "Courses list(1)" }
      within(tab_link) { page.should have_content "Courses(1)" }

      expect do
        ensure_delete_is_working
      end.to change(Gaku::ClassGroupCourseEnrollment, :count).by -1

      within(table) { page.should_not have_content "#{course.code}" }
      within(count_div) { page.should_not have_content "Courses list(1)" }
      within(tab_link) { page.should_not have_content "Courses(1)" }
      flash_destroyed?
    end
  end

end
