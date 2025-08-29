# app/policies/teacher_policy.rb
class TeacherPolicy < ApplicationPolicy
    def index?   = in_school?
    def show?    = in_school?
    def create?  = in_school?
    def update?  = in_school?
    def destroy? = in_school?
  
    class Scope < Scope
      def resolve
        return @scope.all if admin?
        @scope.joins(:school)
              .joins("INNER JOIN school_directors sd ON sd.school_id = schools.id")
              .where("sd.user_id = ?", @user.id)
      end
    end
  
    private
    def admin? = @user&.admin?
    def in_school?
      admin? || @record.school.school_directors.exists?(user_id: @user.id)
    end
  end
  