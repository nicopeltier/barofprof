# app/policies/school_policy.rb
class SchoolPolicy < ApplicationPolicy
    def show?    = admin_or_director_of_school?
    def update?  = admin?                           # l’admin édite l’école
    def destroy? = admin?                           # suppression cascade : admin only
    def create?  = admin?
  
    class Scope < Scope
      def resolve
        return @scope.all if admin?
        @scope.joins(:school_directors).where(school_directors: { user_id: @user.id })
      end
    end
  
    private
    def admin? = @user&.admin?
    def admin_or_director_of_school?
      admin? || @record.school_directors.exists?(user_id: @user.id)
    end
  end
  