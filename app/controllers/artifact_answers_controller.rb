class ArtifactAnswersController < ApplicationController
  
  
  def list_attachments
    @artifact_answer = ArtifactAnswer.find(params[:id])
    @attachments = @artifact_answer.attachments
   render layout: false
  end
 
  def create_attachment
    @artifact_answer = ArtifactAnswer.find(params[:id])
    if params[:file]
      params[:file].each do |attachment|
        @artifact_answer.attachments.create(attachment_file: attachment)
      end
    end
    @attachments = @artifact_answer.attachments
  end
 
  def remove_attachment
    attachment = Attachment.find(params[:id])
    attachment.delete
  end
  
  def list_comment
    @artifact_answer = ArtifactAnswer.find(params[:id])
    render layout: false
  end
  
  def update_comment
    @artifact_answer = ArtifactAnswer.find(params[:artifact_answer][:id])
    @artifact_answer.update_attributes(comment_params)
  end
  
  private

  def comment_params
    params.require(:artifact_answer).permit(:id, comment_attributes: [:comment, :id])
  end
end
