# frozen_string_literal: true

class DocumentsController < ApplicationController
  before_action :set_document, only: %i[edit update show destroy]

  def index
    @documents = Document.includes(:employee)
  end

  def new
    @document = Document.new
  end

  def create
    @document = Document.new(document_params)
    if @document.save
      redirect_to documents_path, notice: 'Document has been created successfull'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @document.update(document_params)
      redirect_to documents_path, notice: 'Document has been updated successfully'
    else
      render :edit
    end
  end

  def show; end

  def destroy
    return unless @document.destroy

    redirect_to documents_path, notice: 'Document has been deleted successfully'
  end

  private

  def document_params
    params.require(:document).permit(:name, :doc_type, :employee_id, :image)
  end

  def set_document
    @document = Document.find(params[:id])
  rescue ActiveRecord::RecordNotFound => e
    redirect_to documents_path, notice: e
  end
end
