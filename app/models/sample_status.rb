class SampleStatus < EnumerateIt::Base
  associate_values(
      :pending   => [1, 'Pending'],
      :running   => [2, 'Running'],
      :completed => [3, 'Completed'],
      :error     => [4, 'Error'],
      :timeout   => [5, 'Timeout']
  )
end