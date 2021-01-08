module Backend.HttpHandlers

open Microsoft.AspNetCore.Http
open FSharp.Control.Tasks
open Giraffe
open Backend.Models


let handleGetProducts =
    fun (next: HttpFunc) (ctx: HttpContext) ->
        task {
            let response = { Text = "Products" }
            return! json response next ctx
        }
