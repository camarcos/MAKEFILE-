# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: camarcos <camarcos@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/10/04 10:50:31 by camarcos          #+#    #+#              #
#    Updated: 2024/11/06 12:22:35 by camarcos         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# NAMES
NAME = pipex
  # nombre del programa final que se generará tras la compilación

# LIBFT
LIBFT = libft/libft.a
  # la ruta a la biblioteca estática libft.a

# SOURCE FILES
SRC_DIR			=	src/
  # directorio donde están los archivos fuente (.c)
SRC_FILES		= 	pipex_utils.c \
                pipex.c \
  # lista de archivos fuente que serán compilados para generar el programa

SRC				=	$(addprefix $(SRC_DIR), $(SRC_FILES))
  # genera rutas completas a los archivos fuente, como src/pipex_utils.c y src/pipex.c

# OBJECT FILES
OBJ_FILES 		= $(SRC:.c=.o)
  # convierte los archivos .c definidos en SRC a archivos de objetos (.o)

# COMPILER OPTIONS 
CC		= gcc
  # es el compilador que se utiliza
FLAGS	= -Wall -Werror -Wextra
  # son las banderas que se utilizan (segun subject)
INCLUDE = -I includes
  # el directorio de encabezados adicionales (-I includes)
RM		= rm -f
  # el comando para eliminar archivos, sin confirmación

# COLORS
RED		=	\033[91;1m # errores o fallos
GREEN	=	\033[92;1m # operacion exitosa
YELLOW	=	\033[93;1m # advertencias o mensajes importantes
BLUE	=	\033[94;1m # mensajes informativos
PINK	=	\033[95;1m # destacar pasos del proceso de compilación
CLEAR	=	\033[0m # después de un texto coloreado vuelva a su formato normal.
  # colores para la salida del terminal en cada caso
  
# MAKEFILE RULES
all:	$(NAME)
  # esta regla se ejecuta al hacer uso de make construyendo un programa ejecutable
$(NAME):	$(OBJ_FILES)
  # impone que primero se tienen que crear los archivos objeto
  # despues genera todos los .o a partir de los .c al compilar
	@make -sC libft
  # llama al mekefile de la libftasegurandose de que ha sido compilada antes de seguir
  # -s suprime la salida de comandos de este proceso, compilaciń menos ruidosa
  # -C indica que el comando make debe cambiar al directorio libft
	@echo "$(PINK)Compiling the PIPEX program.$(CLEAR)"
  # imprime el mensaje para confirmar que se ha compilado correctamente
	$(CC) $(FLAGS) $(OBJ_FILES) $(INCLUDE) $(LIBFT) -o $(NAME)
  # donde se produce la compilación
  # enlaza todas las las flags para 
  # compilar, incluir los objetos, los includes. la libft y el archivo ejecutable 
	@echo "$(GREEN)[OK]\n$(CLEAR)$(GREEN)Success!$(CLEAR)\n"
  # imprime el mensaje confirmando que todo salió bien 

%.o: %.c
	$(CC) $(FLAGS) -c -o $@ $<
  # indica cómo compilar un archivo fuente .c en archivo objeto .o
  # $@ se refiere al archivo objetivo (.o)
  # $< se refiere al archivo fuente (.c)

clean:
	@echo "$(PINK)Removing compiled files.$(CLEAR)"
  # elimina los archivos objeto generados durante la compilación
	@make clean -sC libft
  # invoca make clean en la libft para limpiar esa parte del proyecto
	$(RM) $(OBJ_FILES)
  # 
	@echo "$(GREEN)Object files removed correctly\n$(CLEAR)"
  # imprime mensaje de confirmación de que .o se borraron correctaente

fclean: clean
  # similar a clean, elimina archivos objeto y ejecutables
  # primero invoca a clean
	@make fclean -sC libft
  # elimina los .o y los ejecutables de la libft
	@echo "$(PINK)Removing exec. files.$(CLEAR)"
  # imprime mesaje de confirmación de eliminado y vuelve al color original de la fuente
	$(RM) $(NAME)
  # elimina el ejecutable de pipex 
	@echo "$(GREEN)Exec. files removed correctly\nSuccess!$(CLEAR)"
  # imprime mesaje de confirmación y vuelve al color original de la fuente 

re: fclean all
  # primero se ejecuta el "fclean" eliminando todos los archivos generada
  # despues ejecuta el "all" para recompilar todo desde cero

.PHONY:		all clean fclean re
  # evita que al compilar se confundan estas reglas con archivos normales
  # ayuda a que el Makefile funcione correctamente