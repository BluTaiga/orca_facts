class FactsController < ApplicationController
  before_action :getAllFacts, only: [:index, :destroy]

  http_basic_authenticate_with name: ENV['BASIC_AUTH_USERNAME'], password: ENV['BASIC_AUTH_PASSWORD'], except: [:random_fact]
  
  # Index action for showing all facts
  def index
    getAllFacts
  end

  # Show action for showing a specific fact
  def show
    @fact = Fact.find(params[:id])
  end

  # Action for showing a random fact
  def random_fact
    @fact = Fact.order("RANDOM()").first
    render :random_fact
  end

  # New action for creating fact
  def new
    @fact = Fact.new
  end

  # Create action saves the fact into database
  def create
    @fact = Fact.new(fact_params)
    if @fact.save
      flash[:notice] = "Successfully created fact!"
      redirect_to fact_path(@fact)
    else
      flash[:alert] = "Error creating new fact!"
      render :new, status: :unprocessable_entity
    end
  end

  # Edit action for editing fact
  def edit
    @fact = Fact.find(params[:id])
  end

  # Update action updates the fact with the new information
  def update 
    @fact = Fact.find(params[:id])

    if @fact.update(fact_params)
      flash[:notice] = "Successfully updated fact!"
      redirect_to fact_path(@fact)
    else
      flash[:alert] = "Error updating fact!"
      render :edit, status: :unprocessable_entity
    end
  end

  # Destroy action deletes the fact
  def destroy
    @fact = Fact.find(params[:id])
    @fact.destroy

    flash[:notice] = "Successfully deleted fact!"
    redirect_to facts_path
  end

  private
  def fact_params
    params.require(:fact).permit(:title, :body)
  end

  def getAllFacts
    @facts = Fact.all
  end
end
