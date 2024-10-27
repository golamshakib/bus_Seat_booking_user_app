class SeatAlreadyBookedException implements Exception {

  final List<String> bookedSeats;
  SeatAlreadyBookedException(this.bookedSeats);

  @override
  String toString() {
    return 'Booking unsuccessful. The seat(s) ${bookedSeats.join(", ")} are already booked.';
  }
}
