module AssigningError
  class AlreadyUsedOnOtherUser    < StandardError; end
  class AlreadyAssignedToOther    < StandardError; end
  class AlreadyReturnedByThisUser < StandardError; end
end
