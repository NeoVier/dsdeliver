module Backend.Database.Order

open Backend.Models


let internal statusFromString (status: string): OrderStatus =
    match status with
    | "Pending" -> Pending
    | "Delivered" -> Delivered
    | _ -> Unknown

let internal fromEntity (orderEntity: OrderEntity): Order =
    { Id = orderEntity.Id
      Address = orderEntity.Address
      Latitude = orderEntity.Latitude
      Longitude = orderEntity.Longitude
      Status = statusFromString orderEntity.Status
      Moment = orderEntity.Moment }
