
class ClientException implements Exception{}

/// Insertion Exceptions
class UserNameAlreadyExist extends ClientException{}

class IdentificationNumberAlreadyExist extends ClientException{}

class UnExpectedException extends ClientException{}

/// Update Exception
class UserDoesNotExist extends ClientException{}