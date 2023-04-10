using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authorization;

namespace ChatAppWithReact.Requirements
{
    public class Requirement : IAuthorizationRequirement
    {
    }

    public class RequirementHandler : AuthorizationHandler<Requirement>
    {
        protected override Task HandleRequirementAsync(AuthorizationHandlerContext context, Requirement requirement)
        {
            Console.WriteLine(context.User);
            return Task.CompletedTask;
        }
    }

}
