# app/policies/participation_policy.rb
class ParticipationPolicy < ApplicationPolicy
    def index?  = in_school?
    def show?   = in_school?
    def update? = in_school?     # ex. relances manuelles
    def destroy?= admin?
  
    class Scope < Scope
      def resolve
        return @scope.all if admin?
        @scope.joins(survey: :school)
              .joins("INNER JOIN school_directors sd ON sd.school_id = schools.id")
              .where("sd.user_id = ?", @user.id)
      end
    end
  
    private
    def admin? = @user&.admin?
    def in_school?
      admin? || @record.survey.school.school_directors.exists?(user_id: @user.id)
    end
  end
  