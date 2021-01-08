module Backend.Database.Order

open Backend.Models


let private statusFromString (status: string): OrderStatus =
    match status with
    | "Pending" -> Pending
    | "Delivered" -> Delivered
    | _ -> Unknown

let private statusToString (status: OrderStatus): string =
    match status with
    | Pending -> "Pending"
    | Delivered -> "Delivered"
    | Unknown -> "Unknown"

let internal orderFromEntity (orderEntity: OrderEntity) (products: Product []): Order =
    { Id = orderEntity.Id
      Address = orderEntity.Address
      Latitude = orderEntity.Latitude
      Longitude = orderEntity.Longitude
      Status = statusFromString orderEntity.Status
      Moment = orderEntity.Moment
      Products = products }

let allOrders (ctx: Context): Order [] =
    query {
        for order in ctx.Public.Order do
            sortBy order.Moment
            where (order.Status = statusToString Pending)
            select (order)
    }
    |> Seq.toArray
    |> Array.map
        (fun orderEntity ->
            let products: Product [] =
                query {
                    for relationship in ctx.Public.OrderProduct do
                        where (relationship.OrderId = orderEntity.Id)

                        for product in relationship.``public.product by id`` do
                            select (product)
                }
                |> Seq.toArray
                |> Array.map Product.productFromEntity

            orderFromEntity orderEntity products)

let postOrder (ctx: Context) (order: PostedOrder): Order =
    let products: Product [] =
        query {
            for product in ctx.Public.Product do
                select (product)
        }
        |> Seq.toArray
        |> Array.filter (fun p -> Array.contains p.Id order.ProductIds)
        |> Array.map Product.productFromEntity

    let newOrderEntity =
        ctx.Public.Order.Create(
            order.Address,
            order.Latitude,
            order.Longitude,
            System.DateTime.Now,
            statusToString Pending
        )

    ctx.SubmitUpdates()

    products
    |> Array.map (fun p -> ctx.Public.OrderProduct.Create(newOrderEntity.Id, p.Id))
    |> ignore

    ctx.SubmitUpdates()

    orderFromEntity newOrderEntity products

let setDelivered (ctx: Context) (orderId: int64) =
    let maybeOrderEntity =
        query {
            for o in ctx.Public.Order do
                where (o.Id = orderId)
                select (Some o)
                exactlyOneOrDefault
        }

    match maybeOrderEntity with
    | Some orderEntity ->
        orderEntity.Status <- statusToString Delivered
        ctx.SubmitUpdates()
        true
    | None -> false
