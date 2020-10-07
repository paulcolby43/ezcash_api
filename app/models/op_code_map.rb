class OpCodeMap < ApplicationRecord
#  self.primary_key = 'cassette_id'
  self.table_name= 'OpCodesMap'
  
  scope :key_seq, ->(key_seq) { where("KeySeq = ?", key_seq) unless key_seq.blank?}
  scope :tran_code, ->(tran_code) { where("TranCode = ?", tran_code) unless tran_code.blank?}
  scope :cassette_id, ->(cassette_id) { where("CassetteID = ?", cassette_id) unless cassette_id.blank?}
  scope :swx_pri_tran, ->(swx_pri_tran) { where("SwxPriTran = ?", swx_pri_tran) unless swx_pri_tran.blank?}
  scope :swx_sec_tran, ->(swx_sec_tran) { where("SwxSecTran = ?", swx_sec_tran) unless swx_sec_tran.blank?}
  scope :swx_sec_rev, ->(swx_sec_rev) { where("SwxSecRev = ?", swx_sec_rev) unless swx_sec_rev.blank?}
  
  
  #############################
  #     Instance Methods      #
  #############################
  
  
  
  #############################
  #     Class Methods         #
  #############################
end