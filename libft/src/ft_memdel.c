/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_memdel.c                                        :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: vmartins <marvin@42.fr>                    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2016/11/08 02:21:37 by vmartins          #+#    #+#             */
/*   Updated: 2017/03/31 15:23:36 by vmartins         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "../include/libft.h"

void	ft_memdel(void **ap)
{
	if (!ap || !*ap)
		return ;
	else
	{
		free(*ap);
		*ap = NULL;
	}
}
