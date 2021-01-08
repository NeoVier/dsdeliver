module Backend.Database.Order

open Backend.Models


let private statusFromString (status: string): OrderStatus =
    match status with
    | "Pending" -> Pending
    | "Delivered" -> Delivered
    | _ -> Unknown

let internal orderFromEntity (orderEntity: OrderEntity) (products: Product []): Order =
    { Id = orderEntity.Id
      Address = orderEntity.Address
      Latitude = orderEntity.Latitude
      Longitude = orderEntity.Longitude
      Status = statusFromString orderEntity.Status
      Moment = orderEntity.Moment
      Products = products }

let allOrders: Order [] =
    query {
        for order in context.Public.Order do
            select (order)
    }
    |> Seq.toArray
    |> Array.map
        (fun orderEntity ->
            let products: Product [] =
                query {
                    for relationship in context.Public.OrderProduct do
                        where (relationship.OrderId = orderEntity.Id)

                        for product in relationship.``public.product by id`` do
                            select (product)
                }
                |> Seq.toArray
                |> Array.map Product.productFromEntity

            orderFromEntity orderEntity products)
