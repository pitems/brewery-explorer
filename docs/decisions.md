Decision #3

Network error mapping

A dedicated error mapper (strategy pattern) would provide more granular user
messages depending on DioExceptionType.

Reason for postponing:

- Not required by the exercise.
- Would introduce additional complexity.
- Current implementation already hides Dio from upper layers.

Future improvement:
Create DioExceptionMapper.
