# app/policies/survey_policy.rb
class SurveyPolicy < ApplicationPolicy
    def show?    = in_school?
    def create?  = in_school?        # créer une campagne pour son école
    def launch?  = in_school?
    def remind?  = in_school?
    def close?   = in_school? || admin?
    def report?  = in_school? || admin?
  
    class Scope < Scope
      def resolve
        return @scope.all if admin?
        @scope.joins(:school).joins("INNER JOIN school_directors sd ON sd.school_id = schools.id")
             .where("sd.user_id = ?", @user.id)
      end
    end
  
    private
    def admin? = @user&.admin?
    def in_school?
      admin? || @record.school.school_directors.exists?(user_id: @user.id)
    end
  end
  