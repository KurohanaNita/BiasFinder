import { Controller, Get, HttpException, HttpStatus } from '@nestjs/common';
import { UsersService } from './users.service';

@Controller('users')
export class UsersController {
  // private readonly cest pour dire que c'est private en gros donc on peut pas l'utiliser en dehors de cette classe
  // readonly cest pour dire que c'est une constante donc on peut pas le modifier
  // usersService cest le service qu'on va utiliser pour récupérer les utilisateurs qu'on injecte dans le constructeur
  constructor(private readonly usersService: UsersService) {}

  // si tu veux mettre un parametre tu fous un :id par exemple Get(':id') et ensuite dans ta fonction tu peux faire
  // @Param('id') id: string exemple : findOne(@Param('id') id: string) { mon super code blabla}
  @Get()
  async getAllUsers() {
    try {
      return await this.usersService.findAll();
    } catch {
      throw new HttpException(
        'Unable to retrieve users',
        HttpStatus.INTERNAL_SERVER_ERROR,
      );
    }
  }
}
