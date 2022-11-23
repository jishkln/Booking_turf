
class BookingResponse {
    BookingResponse({
        this.status,
        this.data,
        this.message,
    });

    String? message;
    bool? status;
    List<BookingList>? data;

    factory BookingResponse.fromJson(Map<String, dynamic> json) => BookingResponse(
        status: json["status"],
        data: List<BookingList>.from(json["data"].map((x) => BookingList.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class BookingList {
    BookingList({
        this.bookingDate,
        this.turfId,
        this.timeSlot,
    });

    String? bookingDate;
    String? turfId;
    List<int>? timeSlot;

    factory BookingList.fromJson(Map<String, dynamic> json) => BookingList(
        bookingDate: json["booking_date"],
        turfId: json["turf_id"],
        timeSlot: List<int>.from(json["time_slot"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "booking_date": bookingDate,
        "turf_id": turfId,
        "turf_index": List<dynamic>.from(timeSlot!.map((x) => x)),
    };
}
