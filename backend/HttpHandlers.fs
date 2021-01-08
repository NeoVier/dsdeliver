module Backend.HttpHandlers

open Microsoft.AspNetCore.Http
open FSharp.Control.Tasks
open Giraffe


let handleGetProducts =
    fun (next: HttpFunc) (ctx: HttpContext) ->
        task {
            let response =
                Database.Product.allProducts Database.context

            return! json response next ctx
        }

let handleGetOrders =
    fun (next: HttpFunc) (ctx: HttpContext) ->
        task {
            let response =
                Database.Order.allOrders Database.context

            return! json response next ctx
        }

let handlePostOrders =
    fun (next: HttpFunc) (ctx: HttpContext) ->
        task {
            let payload =
                ctx.BindJsonAsync<Models.PostedOrder>().Result

            let newId =
                Database.Order.postOrder Database.context payload

            return! json newId next ctx
        }
