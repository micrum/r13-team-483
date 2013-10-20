class SampleStatus

  PENDING   = 1
  RUNNING   = 2
  COMPLETED = 3
  ERROR     = 4
  TIMEOUT   = 5

  STATUS_TEXT = {
    PENDING => 'pending',
    RUNNING => 'running',
    COMPLETED => 'completed',
    ERROR => 'error',
    TIMEOUT => 'timeout'
  }

  def self.status_text(status)
    STATUS_TEXT[status] || 'unknown'
  end

end