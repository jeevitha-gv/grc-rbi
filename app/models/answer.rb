class Answer < ActiveRecord::Base

	has_one :checklist_recommendation, as: :checklist
	belongs_to :nc_question
	has_one :attachment , as: :attachable

  delegate :question, :to => :nc_question
  delegate :question_type_name, :to => :nc_question

  # validates :detailed_value, presence:true
  # validates :value, presence:true
  
  # Build Answer form Nc Question selected
  def self.build_answer(params)
    params[:answer] && params[:answer].each do |nc_id, answer|
        attachment = answer.delete("attachment")          
        nc_que = NcQuestion.where(id: nc_id).last
        unless nc_que.answer.present?
            nc_que.answer = Answer.new(answer)
            if params[:commit] == "Submit Answers to Auditor"
              nc_que.is_answered = true
              nc_que.answer.attachment = Attachment.new(attachment_file: attachment) if attachment.present?
              nc_que.save
            end
        else
            nc_que.answer.attachment = nc_que.answer.attachment.nil? ? nc_que.answer.attachment = Attachment.new : nc_que.answer.attachment
            nc_que.answer.attachment.update(attachment_file: attachment) if attachment.present?
            if nc_que.answer.update(answer)
              if params[:commit] == "Submit Answers to Auditor"
                nc_que.is_answered = true
                nc_que.save
              end
            end
        end
    end
  end
  
end
