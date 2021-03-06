class CompaniesController < ApplicationController
  before_action :set_company, only: [:show, :edit, :update, :destroy, :form_allocation]
  before_action :require_logged_in

  # GET /companies
  # GET /companies.json
  def index
    @companies = current_user.companies.all
  end

  # GET /companies/1
  # GET /companies/1.json
  def show
  end

  # GET /companies/new
  def new
    @company = current_user.companies.new
  end

  # GET /companies/1/edit
  def edit
  end

  # POST /companies
  # POST /companies.json
  def create
    @company = current_user.companies.new(company_params)
    respond_to do |format|
      if @company.save!
        # FollowUpJob.new(@company.email, current_user.username).enqueue
        UserMailer.follow_up(@company.email, current_user.username).deliver_now
        format.html { redirect_to @company, notice: 'Company was successfully created.' }
        format.json { render :show, status: :created, location: @company }

      else
        format.html { render :new }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /companies/1
  # PATCH/PUT /companies/1.json
  def update
    respond_to do |format|
      if @company.update(company_params)
        # form_allocation(@company)
        UserMailer.follow_up(@company.email, current_user.username).deliver_now
        format.html { redirect_to @company, notice: 'Company was successfully updated.' }
        format.json { render :show, status: :ok, location: @company }
      else
        format.html { render :edit }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /companies/1
  # DELETE /companies/1.json
  def destroy
    @company.destroy
    respond_to do |format|
      format.html { redirect_to companies_url, notice: 'Company was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def show
  @company = current_user.companies.find(params[:id])
  @company.forms
end

def start_time
    created_at
  end

  def calendar_view
    @company = current_user.companies.find(params[:id])
    @company.forms.all
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_company
      @company = current_user.companies.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def company_params
      params.require(:company).permit(:name, :email, :phone, :partners, :manypartners, :corporation, :scorp, :llc, :soleprop, :employees, :employeebenefits, :contractors, :incomeproperties, :ff, :wagering, :excisetax, :trucking, :agriculture )
    end

end
