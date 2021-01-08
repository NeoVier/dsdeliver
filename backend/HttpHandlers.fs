module Backend.HttpHandlers

open Microsoft.AspNetCore.Http
open FSharp.Control.Tasks
open Giraffe
open Backend.Models


let handleGetProducts =
    fun (next: HttpFunc) (ctx: HttpContext) ->
        task {
            let response = Database.Product.allProducts
            return! json response next ctx
        }

let handleGetOrders =
    fun (next: HttpFunc) (ctx: HttpContext) ->
        task {
            let response = Database.Order.allOrders
            return! json response next ctx
        }
