namespace Backend.Models

type OrderStatus =
    | Pending
    | Delivered
    | Unknown

type Order =
    { Id: int64
      Address: string
      Latitude: double
      Longitude: double
      Status: OrderStatus
      Moment: System.DateTime
      Products: Product [] }
